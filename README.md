# Personality Quiz App

## Overview

This project is an iOS Personality Quiz app based on Apple’s *Develop with Swift Fundamentals* guided project. Users answer a series of questions to receive a personality result.

The app includes additional stretch features such as multiple quiz selection, randomized questions and answers, dynamic UI layouts, a quiz timer, and a history screen for viewing past results. A high-fidelity Figma prototype was created to design and demonstrate the app’s UI/UX and navigation flow.

## Setup Instructions

1. Clone or download the repository.
2. Open the project in Xcode.
3. Ensure a valid iOS simulator is selected.
4. Build and run the project using the Run button.

## Figma Prototype

The high-fidelity interactive prototype for this app was designed using Figma and includes all base screens and required stretch goal features.

👉 Public Figma link:  
https://www.figma.com/design/jRDfhbS7kQO2K1FopMYCkT/Personality-Quiz?node-id=0-1&t=YLvdB0KJEdnpMbGB-1

## Implemented Stretch Features

This project includes the following extensions beyond the base "Personality Quiz" guided project:

### 1. Multiple Quiz Selection
Users can choose between multiple personality quizzes from the intro screen before starting the quiz. This allows the app to support different quiz datasets and improves replayability.

### 2. Randomized Questions and Answers
The order of questions and their corresponding answers is randomized at runtime to ensure that each quiz attempt feels unique and prevents users from memorizing answer positions.

### 3. Dynamic Answer Layout
The quiz dynamically supports different question types:
- Single-answer questions using buttons
- Multiple-answer questions using switches
- Range-based questions using a slider

Answer options are generated programmatically using stack views to handle a variable number of answers.

### 4. Quiz History
A history screen displays previously completed quizzes and their results. Quiz outcomes are stored locally on the device and can be reviewed at any time.

### 5. Quiz Timer
Each quiz question is timed, limiting how long the user has to answer. If the timer expires, the quiz automatically progresses, providing a more engaging and challenging experience.
