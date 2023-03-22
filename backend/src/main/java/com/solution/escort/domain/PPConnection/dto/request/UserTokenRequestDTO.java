package com.solution.escort.domain.PPConnection.dto.request;

import lombok.*;
import lombok.extern.slf4j.Slf4j;

@AllArgsConstructor
@Builder
@Getter
@Setter
@Slf4j
@NoArgsConstructor
public class UserTokenRequestDTO {
    private String deviceToken;

}
