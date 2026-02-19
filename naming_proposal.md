# Improved Domain-Specific Naming Proposal

## SystemLifecycle
### States
| Old Name              | New Name           | Rationale                                                                   |
| :-------------------- | :----------------- | :-------------------------------------------------------------------------- |
| `Booting`             | `Booting`          | Accurate and standard.                                                      |
| `CheckingHardware`    | `CheckingHardware` | Consistent usage of "Checking" + [Component].                               |
| `LiveStreamOnlyAlert` | `LiveStreamOnly`   | Removed "Alert" (UI term). The state represents reduced functionality mode. |
| `LifecycleReady`      | `HardwareReady`    | More specific than "Lifecycle". Indicates hardware checks passed.           |
| `LifecycleError`      | `SystemFatalError` | "System" matches the domain, "Fatal" implies the severity.                  |

### Events
| Old Name                 | New Name                           | Rationale                                                           |
| :----------------------- | :--------------------------------- | :------------------------------------------------------------------ |
| `HardwareCheckInitiated` | `HardwareCheckInitiated`           | Clear and specific.                                                 |
| `HardwarePassed`         | `HardwareCheckPassed`              | Added "Check" for symmetry with Initiated.                          |
| `NoCameraButLiveStream`  | `CameraMissingLiveStreamAvailable` | "Missing" is more formal than "No". Explicitly states availability. |
| `NoCameraNoLiveStream`   | `CameraAndLiveStreamUnavailable`   | Explicitly states unavailability of both.                           |

## AppFlow
### States
| Old Name          | New Name             | Rationale                                                                 |
| :---------------- | :------------------- | :------------------------------------------------------------------------ |
| `WaitForStart`    | `WaitingForStart`    | "Waiting" (continuous) describes a state better than "Wait" (imperative). |
| `BackendChecking` | `CheckingBackend`    | Changed to Verb-Noun to match `CheckingHardware`.                         |
| `NeedsOnboarding` | `OnboardingRequired` | Stronger state description. Matches the condition.                        |
| `Running`         | `SessionRunning`     | "Session" clarifies what is actually running (the counter session).       |

### Events
| Old Name              | New Name              | Rationale                                   |
| :-------------------- | :-------------------- | :------------------------------------------ |
| `Start`               | `StartRequested`      | Events are often past tense or requests.    |
| `NeedOnboarding`      | `OnboardingNeeded`    | Grammatically correct ("Needed" vs "Need"). |
| `OnboardingCompleted` | `OnboardingCompleted` | Keep.                                       |
| `Stop`                | `StopRequested`       | Matches `StartRequested`.                   |

## Documentation Strategy
All states and events will include succinct doc comments explaining *when* this state is active or *what* triggers the event.
