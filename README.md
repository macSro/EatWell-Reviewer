<a name="top"></a>

# EatWell Reviewer

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#downgrading">Downgrading</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#run">Run</a></li>
      </ul>
    </li>
    <li><a href="#features">Features</a></li>
    <li><a href="#demo">Demo</a></li>
  </ol>
</details>

## About The Project

This project is a complementary app to <a href="https://github.com/macSro/EatWell">EatWell</a>. It's function is to enable reviewers to handle missing ingredient inquiries raised by users of the main app. It was created as part of my BEng thesis at _Wrocław University of Science and Technology_.

_For example of use, please refer to the <a href="#demo">Demo</a> section._

### Built With

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)

State management: <a href="https://pub.dev/packages/flutter_bloc">BloC</a>

<p align="right">(<a href="#top">back to top</a>)</p>



## Getting Started

To get a copy of this project running on your machine follow these steps.

### Prerequisites

* Flutter SDK installed _(version < 2.0.0)_

* Dart SDK installed _(version < 2.12.0)_

* IDE configured for development of Flutter applications _(e.g., VS Code)_

### Downgrading

If you have a more recent version of Flutter SDK installed, please downgrade it before the app installation:

1. Navigate to your Flutter SDK directory

2. Switch to a previous version _(e.g., 1.22.6)_:

```
git checkout 1.22.6
```

3. Update Dart SDK automatically:

```
flutter doctor -v
```

<br>

In order to switch back to the most recent version, run the following commands:

```
flutter channel stable

flutter upgrade
```

### Installation

1. Clone this repository:

   ```
   git clone https://github.com/macSro/EatWell-Reviewer.git
   ```

2. Navigate to the cloned directory:

   ```
   cd EatWell-Reviewer
   ```

3. Install the dependencies:

   ```
   flutter pub get
   ```

### Run

1. Inside your IDE select the target device

2. Run the app with IDE "Run" button _(VS Code: F5)_ or by executing:

```
flutter run
```

<p align="right">(<a href="#top">back to top</a>)</p>



## Features 

* Log into the reviewer account (test account: ```test@test.com : test123```)

* Review missing ingredient inquiries



## Demo



<p align="right">(<a href="#top">back to top</a>)</p>
