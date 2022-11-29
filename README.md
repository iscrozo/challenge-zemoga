# Challenge - zmg

## About this project

It is an application challenge performing service consumption and storage in USerDefault.



## Features

- List post of an API
- List post saved in the device
- Display the post with all the corresponding information
- Delete a post
- Delete all records


## Project structure

## ViewModel
> PostDataViewModel: it is responsible for receiving the call from the view, interacting with the services layer for the corresponding Api consumptions, once the response is issued it is returned by the PostViewModelToViewBinding protocol since it is the delegate of the class.
## Information
### Model
> Represents the application domain model, in this case two models are used in this case Post, Post by user, comments from post.
### Persistence
> Represents the structure to store the information by means of UserDefault
## View
> The following views are used for the project:
* ListPostViewController => controller for the main view where it receives the post information from the service or saved posts.
* postViewController => controller where the post information is displayed, who wrote the post and the comments of the post.

## Services
> It is the layer in charge of constructing the url by means of some data for each consumption, and at the same time main function is to make the request with the Api, it is conformed by the following files:
* ApiData is an enum which contains the information of all the url for the search and item api.
* ApiBuild is in charge of generating a URLRequest output from ApiData.
* ApiClient its function is to interact with the [API](https://jsonplaceholder.typicode.com//)
* ApiError is an enum that throws the error
 
## Resources
> The following parameterizable resources are used for the project:
* Images => is the asset in charge of storing the images for the project such as logo and template images.
* Colors => is the asset in charge of storing the colors of the app in hex format.
* Constants => is a file that contains static variables of string type that contains each one of the names or resources that can be parameterized directly in that file, and not on other files since this would generate a little delayed maintenance.
* Fonts => the Lato font is used.

## Utility
> NotificationBannerRender is a utility to make use of the NotificationBanner library at the time of notifications and not have one for each file.

# Dependencies
> For the project the following dependencies were used, and the CocoaPods dependency manager was used
* PureLayout => is a library that extends UIView / NSView, NSArray and NSLayoutConstarint generating a fully developer friendly interface with programmatic design. see [PureLayout info](https://cocoapods.org/pods/PureLayout)
* SkeletonView => is an alternative library to generate an "action loading" known as loading while obtaining the information for rendering, this layer is used over any type of view like label, image, etc. see [SkeletonView info](https://cocoapods.org/pods/SkeletonView)
* NotificacionBannerSwift => is a library for rendering notifications that are displayed from the top of the screen offering a variety of layouts, [NotificationBanner info](https://cocoapods.org/pods/NotificationBanner)


## API Reference
The test is performed with this [API](https://jsonplaceholder.typicode.com//) which has the following segments

#### Get all post

```http
  GET /posts
```
#### Get User from Post
```http
  GET /users
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `id` | `string` | **Required**. This value is the id from Post |

#### Get comments from Post

```http
  GET /comments
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `postId`      | `string` | **Required**. This value is the id from Post |



## Tech

Dillinger uses a number of open source projects to work properly:

- [swift] - language iOS
- [cocoapods] - dependencies


## Installation

Dillinger requires [xcode](https://developer.apple.com/xcode//), [homebrew](https://formulae.brew.sh/formula/cocoapods)

Install the dependencies of cocoapods

```sh
pod install
```

## Support

For support, email iscrozo@gmail. Thank you!
