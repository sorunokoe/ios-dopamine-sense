
# 🌊 Dopamine Sense

This app helps understand how **dopamine affects mood** by tracking daily activities and predicting emotional states.

## Development:

### 1. Measurable:
#### Measurement & Metrics Driven Development

Development stage: XCTest.\
Beta stage: MetricKit.\
Public Release stage: MetricKit, Xcode Metrics Orginizer.

#### Metrics:
- Build time [~4s]
    - Resolving dependencies time ✅ [~0.01]
    - Compile time ✅ [~2s]
        - SIL Optimizations 🟡
    - Linking time ✅ [~0.01]
- Tests
     - Test time (Unit, UI) ✅ [~5s]
     - Test coverage ✅ [70%]
     - Time/Coverage ✅ [0.07]
- Launch time
    - Application launch ✅ [1.1s]
    - Loading Mach-O, dylb time 🟡
- App size
    - Targets 🟡
    - Frameworks 🟡
    - Bundles 🟡
        - Assets.car
        - Other resources
- Performance
    - Memory ✅
        - Physical Memory: On Launch [4mb]
    - CPU ✅
        - CPU time On Launch [0.088s]
        - CPU Instructions Retired [422m]
        - CPU Cycles [208mC] 
    - Storage (I/O) ✅ [0kB]
    - Hitches ✅ [none]
    - Others (Networking, Battery, Signpost Metrics) 🟡

---

### 2. Testable
#### Type-Driven Design & Test-Driven Development

- Type system
- XCTest & SwiftTest:
    - Unit tests
    - Integration tests
    - UI tests

Other tests to consider:
- Snapshot tests 🟡
- Layout tests 🟡

---

### 3. Scalable
#### Modularization
Static libraries when possible & Mergable dynamic libraries

- Swift Package Manager
    - UI (Design System)
    - Data Source
    - Network
    - Core

#### What we want to achieve?
- Resolve conflicts between teams work
- Even if we decide to go with SwiftUI, UIKit or TCA, MVC or any other solution - it should be easily extended or substituded.
- Optimize time to deliver by caching compiled and tested modules

---

### 4. Automatable

- Design System 🟡
    - Pull resources from Figma (colors, icons, images, fonts)
- Localization 🟡
    - Add translations

#### CI/CD Pipelines:
- 👾 Pull Request [~3m]
    - Build ✅
    - Test: Pull Request Test Plan ✅
    - Static Analyzer 🟡
        - SonarQube
        - Checkmarks
        - Linting
    - Memory analyzer 🟡
- ☀️ Daily
    - Archive ✅
- 🤖 Performance
    - Build ✅
    - Test: Performance Test Plan ✅

---

## Our strategy
### What is true about our development process?
- ⭕️ We want to deliver frequently, stable, high-quality, measurable, testable, scalable and automatable features.
- ⭕️ We want to grow as a team reviewing the development process based on the metrics.
- ⭕️ We want to optimize development time and automate tasks when possible
- ⭕️ We want to avoid dialects.
- ❓ If there will be millions of users - what is our strategy? 
    - ⭕️ Define bottlenecks and continuosly measuring, testing and improving the solution.
- ❓ If there will be million of tests - what strategy should we use to work with testing? 
    - ⭕️ Perfect result: Run only those tests that weren't tested before. Other tests should be splitted and run on schedule.
- ❓ What is the ratio of test time and test coverage we want to achieve?
    - ⭕️ Perfect result: Close to the 0. (Example: 1s/99%)
- ❓ What is our definition of delivering the product?
    - ⭕️ Product delivered when user downloaded the app, can access to the essential features.
- ❓ What is our strategy of the delivering the product?
    - ⭕️ Product should be ready to be shipped any time.
- ❓ What is the lifecycle of our feature?
    - ⭕️ Feature should be asked in different stages: before development, during development and after development. For each of the stage should be metrics to measure. (ex.: Feedback Loop)


