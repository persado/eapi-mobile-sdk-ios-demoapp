# Persado iOS SDK Example

This iOS project serves as an example project demonstrating the integration of the Persado Mobile SDK. The app showcases a mock online shop where you can explore the implementation of the SDK in a practical setting.

The project is written in SwiftUI and developed using Xcode 15.0.1. To get started, follow the instructions below.

## Installation

1. Clone the repository to your local machine:

2. Open `persado-sdk-example.xcodeproj` using Xcode.

## Configuration

Before running the app, you need to configure the Persado Mobile SDK with your specific settings. Follow the steps below to set up the required values.

Open `/Helpers/AppConstants.swift`, find and fill in the following variables:
   - `persadoAppId`: This is the App ID of your Persado project.
   - `persadoCampaignLabel`: This is the label of the campaign that is configured under your Persado account.
   - `touchPointName`: This is the label of the touch point that the Persado SDK will be populating.


## Usage

The Persado Mobile SDK is integrated into a mock online shop within the app. This allows you to see how the SDK is implemented and interact with it. Additionally, some hardcoded content is provided for demonstration purposes.

### Products

The app includes a file called `products.json` located in the `Resources` directory. This file contains information about the available products in the mock online shop. You can modify this file to add, remove, or update products as needed.

### Customers

The `customers.json` file, also located in the `Resources` directory, contains mock data of different Personas that can be selected as the current customer browsing the store. You can modify this file to include different customer profiles or update existing ones.

## Running the App

Once you have configured the Persado Mobile SDK and made any necessary changes to the product and customer data, you can run the app on an iOS simulator. Simply build and run the app using Xcode.


## License

This project is licensed under the [BSD 3-Clause License](https://opensource.org/license/bsd-3-clause/).

```
BSD 3-Clause License

Copyright (c) 2022, Persado
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
