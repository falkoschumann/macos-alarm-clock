# Contributing

This document describes the architecture of the application _Alarm Clock_.

![Context](doc/context.png)

There are two actors and and one resource. The actors are the user and the system clock. The resource is the alarm bell.   

## Domain

### Dialog Alarm Clock

#### System clock tick

*   Update display of current time.
*   Update display of remaining time while alarm is switched on.
*   Check if wake up time has been reached.
*   Sound alarm if wake up time has been reached.
*   Switch off checking for wake up time, if wake up time has been reached.

#### Switch on the alarm

*   Switch on checking for the wake up time.

#### Switch off the alarm

*   Switch off checking for the wake up time.

## Flow

![Flow Design](doc/flow-design.png)

__Legend:__

*   Circle - Functional Unit
*   Rectangle - Portal
*   Triangle - Provider
*   <span style="color: #3366ff">Blue</span>: UI Thread
*   <span style="color: #ff0000">Red</span>: Clock Thread
