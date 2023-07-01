# iOS-MVVM-Demo

This project demonstrates the MVVM usage in iOS.

 _Note: No third party SDK is used._

Tasks:
1. Fetches data from network
2. Binds data with models and displays in the list
3. Custom rules are run in order to handle the selection of the items


`FacilityViewModel` view model contains all the business logic to fetch the data from the service and managing rules for selection. It is agnostic of view and publishes events notifying the listener view.

By default, static selection rules are run from `FacilityModel` model. And hence the data fetched from the network is not used. In order to use the data from the network, uncomment `completion` handler from `FacilityNetworkService.swift` file.
