# How to use this addon
This addon is usefull to your game making if you apply a bit of modelisation rigor in your creative process:

1. Birth of your game idea
2. Search for graphical and gameplay references
3. Write a Game Design Document (GDD)
4. Initial modelisation  
    a. List entities  
    b. List the entities responsabilities  
    c. List the entities relationships necessary to perform it's responsabilities. Relationships can be of type:  
        - ⚡ Signal emition  
        - 🔌 Signal subscription  
        - ⛓️ Direct references  
        - 🧊 Collisions  
    d. Establish the node hierarchy of your scene  
    e. List the entities game design variables
    f. List the entities the public functions other entities will call  
    g. Establish for each entity it's type / does it herit from a class
5. Apply the initial modelisation in godot
    - Build the scene hierarchy
    - Create the scripts and classes
        - Inheritance `extends <parent_class_name>`
        - Name `class_name <class_name>`
        - Responsabilities `# @respo: <responsability>`
        - Signals (declaration and subscription)
        - Direct references
        - Game design variables
6. Write your game logic
7. Periodicly check the distance between your game's modelisation and the initial one using the **model check addon**

Steps 5, 6 and 7 can reveal errors in the initial modelisation written at step 4. Modelisation should evolve to better answer your game's technical needs, and the **model check addon** helps you visualise those changes. _Modelisation is an iterative process_.

# Applied exemple
Let's apply the methode described to godot's tutorial 3D game: [Squash the creeps](https://docs.godotengine.org/en/stable/getting_started/first_3d_game/index.html)
![](https://docs.godotengine.org/en/stable/_images/squash-the-creeps-final.gif)

4. Initial modelisation  
    a. List entities
  
In a table, we list the game's entities. At this early stage of modelisation, it is very common to forget to include an entity. It is normal to come back to previous modelisation steps in light of the discovery of a new constraint.
| Entity |
|--------|
| Player |
| Ennemy |
| Score  |


    b. For each entity list it's responsabilities

| Entity      | Responsabilities             |
|-------------|------------------------------|
| Player      | Move, jump, land on ennemies |
| Ennemy      | Move randomly, kill player   |
| Score       | Display the score            |
| GameManager | Count up the score           |

 
    c. For each entity list the relationships necessary to perform it's responsabilities. Relationships can be of type:  
        - ⚡ Signal emition  
        - 🔌 Signal subscription  
        - ⛓️ Direct references  
        - 🧊 Collisions  

| Entity      | Responsabilities             | Relationships   |
|-------------|------------------------------|-----------------|
| Player      | Move, jump, land on ennemies | 🧊 Ennemy       |
| Enemy       | Move randomly, kill player   | ⚡ enemy_killed |
| Score       | Display the score            |                 |
| GameManager | Count up the score           | 🔌 enemy_killed |
|             |                              | ⛓️ Score        |

    d. Establish the node hierarchy of your scene  

```
- MainScene
    - GameManager
    - Ground
    - Player
        - PlayerCollision
    - EnemyManager
        - Enemy
        - ...
    - UI
        - Score
```
At this stage, we realies, the need for a `Ground` and `EnemyManager` entities:
| Entity       | Responsabilities              | Relationships   |
|--------------|-------------------------------|-----------------|
| Ground       | Collisions                    |                 |
| EnemyManager | Spawn enemies, object pooling | 🔌 enemy_killed |

    e. For each entity list the game design variables it's logic should rely on and be exposed in the editor  

| Entity       | Responsabilities              | Game Design Parameters        |
|--------------|-------------------------------|-------------------------------|
| Player       | Move, jump, land on ennemies  | speed, jump_height, init_life |
|              | get_hit, die                  |                               |
| Enemy        | Move randomly, kill player    | speed                         |
| Score        | Display the score             |                               |
| GameManager  | Count up the score, end_game  |                               |
| Ground       | Collisions                    |                               |
| EnemyManager | Spawn enemies, object pooling | spawn_rate, max_enemy         |

At this stage, we realise that the player can get hit and the GameManager is responsible for ending the game. 2 new relationships: Player ⚡ player_die, GameManager 🔌 player_die.

    f. For each entity list the public functions other entities will call  

| Entity       | Responsabilities              | Public functions |
|--------------|-------------------------------|------------------|
| Player       | Move, jump, land on ennemies  |                  |
|              | get_hit, die                  |                  |
| Enemy        | Move randomly, kill player    |                  |
| Score        | Display the score             | set_score        |
| GameManager  | Count up the score, end_game  |                  |
| Ground       | Collisions                    |                  |
| EnemyManager | Spawn enemies, object pooling |                  |

    g. Establish for each entity it's type / does it herit from a class  

```
- MainScene: Node2D
    - GameManager <- Node
    - Ground: 
    - Player:
        - PlayerCollision
    - EnemyManager
        - Enemy
        - ...
    - UI
        - Score
```