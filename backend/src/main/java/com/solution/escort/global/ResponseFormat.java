package com.solution.escort.global;

import lombok.Getter;

@Getter
public class ResponseFormat<T> {
    private final String code;

    private final String message;

    private T result;

    public ResponseFormat(ResponseStatus status) {
        this.code = status.getCode();
        this.message = status.getMessage();
    }

    public ResponseFormat(ResponseStatus status, T result){
        this.code = status.getCode();
        this.message = status.getMessage();
        this.result = result;
    }
}
