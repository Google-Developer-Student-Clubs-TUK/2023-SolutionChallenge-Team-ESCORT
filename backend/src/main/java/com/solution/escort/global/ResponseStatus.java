package com.solution.escort.global;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ResponseStatus {
    // event 응답 status
    POST_EVENT_SUCCESS("E000", "이벤트 생성 성공"),
    GET_EVENT_SUCCESS("E001", "이벤트 가져오기 성공"),
    PUT_EVENT_SUCCESS("E002", "이벤트 수정하기 성공"),

    // image 응답 status
    POST_IMAGE_SUCCESS("I000", "이미지 생성 성공");

    private final String code;
    private final String message;
}
