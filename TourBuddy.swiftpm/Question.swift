//
//  Question.swift
//  TourBuddy
//
//  Created by NANA on 3/23/24.
//

import Foundation

struct Question {
    var title: String
//    var image: String
    var score1: Float
    var score2: Float
    var score3: Float
    var score4: Float
}

//#if DEBUG
var Questions = [Question(title: "나는 철저하게 계획을 세우고 그대로 가고 싶어.", score1: 0.1, score2: 0.0,score3: 0.0, score4: 0.0 ),
                 Question(title: "나는 공금을 만들어서 사용하고 싶어.", score1: 0.0, score2: 0.1,score3: 0.0, score4: 0.1 ),
                 Question(title: "여행을 즐겁게 하기 위해서는 우리만의 규칙이 필요해", score1: 0.1, score2: 0.0,score3: 0.0, score4: 0.0 ),
                 Question(title: "돈이 남더라도 환전은 여유롭게 해야돼", score1: 0.0, score2: 0.1,score3: 0.0, score4: 0.0 ),
                 Question(title: "가고 싶은 곳이 다르다면 따로 움직여도 괜찮아", score1: 0.0, score2: 0.0,score3: 0.0, score4: 0.1 ),
                 Question(title: "여기까지 왔는데 본전은 뽑아야지.\n나는 많이 돌아다니고 싶어.", score1: 0.0, score2: 0.0,score3: 0.1, score4: 0.1 ),
                 Question(title: "내 시간은 소중해. 비싸더라도 고가항공을 이용할래", score1: 0.1, score2: 0.0,score3: 0.0, score4: 0.0 ),
                 Question(title: "숙소가 비싸도 편하고 좋은 곳으로 가고 싶어", score1: 0.0, score2: 0.0,score3: 0.1, score4: 0.0 ),
                 Question(title: "돈이 많이 들더라도 편하게 택시를 타고 싶어", score1: 0.0, score2: 0.0,score3: 0.1, score4: 0.0 ),
                 Question(title: "피곤하더라도 하루 세끼를 꼭 챙겨야돼", score1: 0.0, score2: 0.0,score3: 0.1, score4: 0.0 ),
]
//#endif
