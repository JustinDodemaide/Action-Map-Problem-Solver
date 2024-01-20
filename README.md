# Action Map Problem Solver (AMPS)

<p align="center">
  <img src="https://github.com/JustinDodemaide/Action-Map-Problem-Solver/assets/103222511/c6f05b16-cfd4-427e-8387-96814f71744e" />
</p>

This project is a demonstration of an AI decision making algorithm inspired by [Jeff Orkin's Goal Oriented Action Programming (GOAP)](https://www.gamedeveloper.com/design/building-the-ai-of-f-e-a-r-with-goal-oriented-action-planning), made in Godot 4.0. The Action Map Problem Solver (AMPS) applies depth-first search to an adjacency list of predefined actions in order to find the plan with the most ideal opportunity cost to accomplish a goal.

## How to Use the Demo:
#### [In-Browser Demo](https://jusltin.itch.io/actiontrees-demo?secret=oCp4xMRg6Vy2ZATbSwFnS7i2TrU)

Control the player character (the one that starts on the left) using WASD.

In the top left corner is the Action Pool. These are the actions available to the non-player character. Using the toggle buttons, you can see how giving or taking away actions influences the decisions of the NPC.

Underneath the NPC is their *plan* and their *states*. States are changed by the decision making algorithm, but can also be manually toggled to see how the NPC reacts.

## How it Works:

AMPS is an automated planning process, carried out by AI agents, that attempts to create a sequence of actions to achieve a goal.

Every AI character has a set of *states*. For example, the agent in the demo has states such as "has_enemy", "has_weapon", and "covered". The demo allows the user to toggle these states manually.

Every *agent* has a set of one or more goals. Each goal is a desired condition for a state. In the demo, the agent's highest priority goal is "has_enemy" = false, followed by "chill" = true. To achieve this desired state, the agent traverses an *action map* to find the most ideal sequence of actions, or *plan*.

Actions are defined by *preconditions*, states that must have a certain condition for the action to be performed; and *effects*, states that will have their condition changed if the action is performed successfully. Actions are also able to calculate their opportunity cost, or *score*, by evaluating environmental and character conditions.

Before or during runtime, the action map is calculated using a list of actions available to the character as specified by the programmer. The map is an adjacency list that organizes actions by their effects. For example, action_map[{"has_weapon" = true}] includes the action "PickUpWeapon".

If you want to give an agent more actions, its as simple as adding them to that agent's action pool. The demo demonstrates this process by allowing the user to toggle options on and off, adding or removing them from the pool and calculating a new action map.

Every update (updates happen every 0.1 seconds in the demo, but can be changed to faster or slower increments), the agent traverses the action map, starting with the goal state and recursively traversing the actions whose effects correlate to that state. This process constructs an N-ary tree, in which each node of the tree stores its parent and n number of children.

When all paths have been explored, the leaf containing the best score is traversed upward using each node's stored parent, and each node's action is pushed into a queue. This queue is the plan that, if carried out successfully, will accomplish the agent's desired goal. This plan is visible under the NPC in the demo.

Each update, if an action isn't already being performed, the agent performs the action at the front of the plan queue. If the action isn't valid, the entire plan is erased.

There is also a *sensor* module that the character can use to update to their states. In the demo, it consists of Area2Ds and RayCast2Ds to that allow them to "see" the player if their view isn't obstructed. This can be expanded to included other senses, like hearing.

AMPS borrows heavily from Jeff Orkin's Goal Oriented Action Planning. The biggest difference between the two is in the generation of plans. Whereas GOAP generates a graph of actions and traverses the graph using A* search algorithm, AMPS traverses precalculated adjacency lists of actions using depth-first search.

## Pros and Cons:

### Pros:
**Modularity/Scalability:** Other decision making algorithms, like decision trees or finite state machines, suffer from a lack of scalability and tend to get out of control when a greater number of behaviors are added. AMPS avoids this problem by allowing each action to be an independent module that can be integrated easily.

**Flexible AI:** Because there's no maximum length of an action plan, AI characters are able to execute elaborate plans that wouldn't otherwise be possible with a different decision making process.

**Predefining Adjacency Lists**: In GOAP, the action graph must be calculated during runtime. In AMPS, adjacency lists can be made by hand before runtime to avoid the performance cost.

### Cons:
**Performance:** 
* Because AMPS' decision making process involves traversing a graph, its going to be much slower than other AI approaches, like the 'if' based finite state machine.
* Because each action path must be explored before the most ideal one can be chosen, a lot of time is wasted on paths with exceptionally low scores
* Requires a lot of function calls, increasing branch overhead
* Checking the validity of each action before its performed increases robustness at expense of performance.

**Portability:** This system is complicated and difficult to implement, which makes converting it to other languages and engines difficult.
  
**Opportunity Cost:** Because this system takes a long time to implement, it would not be worthwhile to use it for AI characters that have a smaller number of behaviors.

## Potential Improvements:

* Allow the goals to change priority depending on the conditions of the environmet or AI character.
* Interrupt the current action: At present, the agent must wait for the action to finish before it can it can form a new plan.

## Acknowledgements:
Tileset + character sprites: [Tech Dungeon: Roguelite by pupkin](https://trevor-pupkin.itch.io/tech-dungeon-roguelite)

[Holistic3D's series on GOAP in Unity](https://www.youtube.com/watch?v=tdBWk2OVCWc&list=PLi-ukGVOag_1DCBZG1rRg_SpiyI6I5Qcr) helped me understand GOAP in general and gave me the idea to store path costs in leaf nodes

