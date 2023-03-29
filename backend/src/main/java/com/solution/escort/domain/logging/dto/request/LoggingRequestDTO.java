package com.solution.escort.domain.logging.dto.request;

import lombok.*;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;

@AllArgsConstructor
@Builder
@Getter
@Setter
@Slf4j
@NoArgsConstructor
public class LoggingRequestDTO {
    private String protectorUId;

    private String protegeUId;

    private LocalDateTime reportTime;


}
