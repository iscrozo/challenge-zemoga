//
//  challenge_zemogaTests.swift
//  challenge-zemogaTests
//
//  Created by Camilo Rozo on 29/11/22.
//

import XCTest
@testable import challenge_zemoga

class challenge_zemogaTests: XCTestCase {

    
    var dataAllPost: String!
    var dataGet1Post: String!
    
    private var persistenceData = PersistenceData()
    
    override func setUp() async throws {
        dataAllPost = readFilejson(asFileName: ConstantsTest.dataAllPost)
    }

    func testSavePost() throws {
        guard let getAllPost = ArrayPost(asJsonString: dataAllPost) else {
            XCTFail("Error al obtener los post")
            return
        }
        XCTAssertNotNil(getAllPost, "Listado de post")
        
        guard let data1Post = getAllPost.first else {
            XCTFail("Error al obtener el primer registro")
            return
        }
        
        XCTAssertEqual(data1Post.id, 1)
        XCTAssertEqual(data1Post.userID, 1)
        XCTAssertEqual(data1Post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(data1Post.body,  "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        // save post
        persistenceData.trySavePost(postData: data1Post)
        let  dataCount = persistenceData.getPostByUser()
        
        XCTAssertEqual(dataCount.first?.id, 1)
    }
    
    func testAddManyPostSave() throws {
        guard let getAllPost = ArrayPost(asJsonString: dataAllPost) else {
            XCTFail("Error al obtener los post")
            return
        }
        XCTAssertNotNil(getAllPost, "Listado de post")
        
        persistenceData.removeAllPost()
        
        guard let data2 = getAllPost.filter({ $0.id == 2}).first else {
            XCTFail("Error al obtener el 2nd registro")
            return
        }
        guard let data6 = getAllPost.filter({ $0.id == 6}).first else {
            XCTFail("Error al obtener el 6th registro")
            return
        }
        guard let data23 = getAllPost.filter({ $0.id == 23}).first else {
            XCTFail("Error al obtener el 23rd registro")
            return
        }
        
        persistenceData.trySavePost(postData: data2)
        persistenceData.trySavePost(postData: data6)
        persistenceData.trySavePost(postData: data23)
        
        let  dataCount = persistenceData.getPostByUser()
        XCTAssertEqual(dataCount.count, 3)
        persistenceData.removeAllPost()
    }
    
    func testDeleteIdPost() throws {
        
        guard let getAllPost = ArrayPost(asJsonString: dataAllPost) else {
            XCTFail("Error al obtener los post")
            return
        }
        XCTAssertNotNil(getAllPost, "Listado de post")
        
        guard let data1Post = getAllPost.first else {
            XCTFail("Error al obtener el primer registro")
            return
        }
        
        XCTAssertEqual(data1Post.id, 1)
        XCTAssertEqual(data1Post.userID, 1)
        XCTAssertEqual(data1Post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(data1Post.body,  "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        // save post
        persistenceData.trySavePost(postData: data1Post)
        let  dataArray = persistenceData.getPostByUser()
        XCTAssertEqual(dataArray.first?.id, 1)
        
        
        // delete post
        persistenceData.deletePostId(postData: data1Post)
        let  dataArray1 = persistenceData.getPostByUser()
        XCTAssertEqual(dataArray1.count, 0)
        
    }
    
    func testDeleteAllPost() throws {
        
        guard let getAllPost = ArrayPost(asJsonString: dataAllPost) else {
            XCTFail("Error al obtener los post")
            return
        }
        XCTAssertNotNil(getAllPost, "Listado de post")
        
        guard let data1Post = getAllPost.first else {
            XCTFail("Error al obtener el primer registro")
            return
        }
        // save post
        persistenceData.trySavePost(postData: data1Post)
        let  dataArray = persistenceData.getPostByUser()
        XCTAssertEqual(dataArray.first?.id, 1)
        XCTAssertEqual(dataArray.first?.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        
        // delete all post
        persistenceData.removeAllPost()
        let  dataArray1 = persistenceData.getPostByUser()
        XCTAssertEqual(dataArray1.count, 0)
        
    }
    
    
}

extension challenge_zemogaTests {
    func readFilejson(asFileName: String) -> String{
        let lobFilePath = Bundle(for: challenge_zemogaTests.self).url(forResource: asFileName, withExtension: ConstantsTest.typeExtensionJson)
        guard let lobDataFile = lobFilePath else {
            XCTFail("No se identifico la ruta del archivo \(asFileName)")
            return ""
        }
        guard let lobContentData = try? Data(contentsOf: lobDataFile) else {
            XCTFail("No es posible return el contenido de \(asFileName)")
            return ""
        }
        return String(decoding: lobContentData, as: UTF8.self)
    }
}
