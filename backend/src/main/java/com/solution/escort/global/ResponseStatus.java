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

    // Protector(보호자) 응답 status
    POST_PROTECTOR_SUCCESS("PR000", "보호자 회원 생성 성공"),
    GET_PROTECTOR_SUCCESS("PR001", "보호자 정보 가져오기 성공"),
    PUT_PROTECTOR_SUCCESS("PR002", "보호자 정보 수정하기 성공");

    private final String code;
    private final String message;
}
