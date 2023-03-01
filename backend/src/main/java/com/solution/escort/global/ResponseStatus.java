package com.solution.escort.global;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ResponseStatus {
    // Protege(노인) 응답 status
    POST_PROTEGE_SUCCESS("PE000", "노인 회원 생성 성공"),
    GET_PROTEGE_SUCCESS("PE01", "노인 정보 가져오기 성공"),
    PUT_PROTEGE_SUCCESS("PE02", "노인 정보 수정하기 성공"),
    PUT_PROTEGE_CLOTHING_SUCCESS("PE03", "노인 옷차림 추가 성공"),

    // Protector(보호자) 응답 status
    POST_PROTECTOR_SUCCESS("PR000", "보호자 회원 생성 성공"),
    GET_PROTECTOR_SUCCESS("PR001", "보호자 정보 가져오기 성공"),
    PUT_PROTECTOR_SUCCESS("PR002", "보호자 정보 수정하기 성공"),


    // SOS 신고 응답 status
    POST_SOS_SUCCESS("SOS000", "노인 신고 생성 성공"),
    GET_SOS_SUCCESS("SOS001", "노인 신고 정보 가져오기 성공"),
    DELETE_SOS_SUCCESS("SOS002", "노인 신고 삭제 성공"),

    // Protector(보호자) Protege(노인) 응답 status
    POST_PPCONNECTION_SUCCESS("PP000", "보호자 노인 등록 성공");

    private final String code;
    private final String message;
}
