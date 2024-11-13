
# 🌊 Dopamine Sense

This app helps understand how **dopamine affects mood** by tracking daily activities and predicting emotional states.

## Development:

### 1. Measurable:
#### Measurement & Metrics Driven Development

Development stage: XCTest.\
Beta stage: MetricKit.\
Public Release stage: MetricKit, Xcode Metrics Orginizer.

#### Metrics:
- Build time
    - Resolving dependencies time
    - Compile time
        - SIL Optimizations
    - Linking time
- Test time
     - Tests time (Unit, UI)
     - Test coverage
- Launch time
    - Application launch
    - Loading Mach-O, dylb time
- App size
    - Targets
    - Frameworks
    - Bundles
        - Assets.car
        - Other resources
- Performance
    - Memory
    - CPU
    - Storage (I/O)
    - Hitches
    - Others (Networking, Battery, Signpost Metrics)

---

### 2. Testable
#### Type-Driven Design & Test-Driven Development

- Type system
- Unit tests
- Integration tests
- UI tests

Other tests to consider:
- Snapshot tests
- Layout tests

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

- Design System
    - Pull resources from Figma (colors, icons, images, fonts)
- Localization
    - Add translations

#### CI/CD Pipelines:
- Merge Request
    - Test
    - Static Analyzer
        - SonarQube
        - Checkmarks
        - Linting
    - Memory analyzer
- QA
    - Ship to the internal and/or external testers
- Release
    - Ship to the public release

---

## Our strategy
### What is true about our development process?
- ⭕️ We want to deliver frequently, stable, high-quality, measurable, testable, scalable and automatable features.
- ⭕️ We want grow as a team reviewing the development process based on the metrics.
- ⭕️ We want to optimize development time and automate tasks when possible
- ⭕️ We want to avoid dialects.
- ❓ If there will be millions of users - what is our strategy? 
    - ⭕️ Define bottlenecks and continuosly measuring, testing and improving the solution during the development process (not after QA, real user findings)
- ❓ If there will be million of tests - what strategy should we use to work with testing? 
    - ⭕️ Perfect result: Run only those tests that weren't tested before
- ❓ What is the ratio of test time and test coverage we want to achieve?
    - ⭕️ Perfect result: Close to the 0. (Example: 1s/99%)
- ❓ What is our definition of delivering the product?
    - ⭕️ Product delivered when user downloaded the app, can access to the essential features.
- ❓ What is our strategy of the delivering the product?
    - ⭕️ Product should be ready to be shipped any time.
- ❓ What is the lifecycle of our feature?
    - ⭕️ Feature should be asked in different stages: before development, during development and after development. For each of the stage should be metrics to measure. (ex.: Feedback Loop)


