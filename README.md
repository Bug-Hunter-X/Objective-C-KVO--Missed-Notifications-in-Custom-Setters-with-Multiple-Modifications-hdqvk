# Objective-C KVO Bug: Missed Notifications in Custom Setters

This repository demonstrates a subtle bug in Objective-C's Key-Value Observing (KVO) mechanism. When a custom setter modifies the observed property multiple times, KVO might only notify observers of the final change, missing intermediate updates.

## The Bug
The issue arises when a custom setter modifies the observed property more than once before calling `willChangeValueForKey:` and `didChangeValueForKey:`.  KVO only tracks changes after the setter completely finishes its execution, thus ignoring any intermediate states.

## Reproduction
The `bug.m` file contains a sample class showcasing this behavior.  Run the provided code to observe the unexpected KVO notification only reflecting the final string modification.

## Solution
The `bugSolution.m` file provides a corrected implementation.  Instead of modifying the property multiple times within the setter, use intermediate variables to track changes. Then, call `willChangeValueForKey:` and `didChangeValueForKey:` correctly to notify observers of each significant modification.

This demonstrates the importance of proper KVO usage, especially in complex custom setters.