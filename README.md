# Challenge - zmg

## About this project

It is an application challenge performing service consumption and storage in USerDefault.

List View
* table where you can visualize the posts by service or that are stored.
in the navigation bar we find a button which reloads the table with the saved data.

When clicking on an item in the list by service, we find the following
* star button: the record is saved
* view with the description of the post, the user who made it and the comments of this one.

## Features

- List post of an API
- List post saved in the device
- Display the post with all the corresponding information
- Delete a post
- Delete all records

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
