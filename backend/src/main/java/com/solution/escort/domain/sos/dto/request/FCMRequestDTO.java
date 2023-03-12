package com.solution.escort.domain.sos.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class FCMRequestDTO {
    //private String title;
    private String body;
    private String targetToken;
}
