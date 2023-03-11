package com.solution.escort.domain.PPConnection.dto.response;

import lombok.*;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@AllArgsConstructor
@Builder
@Getter
@Setter
@Slf4j
@NoArgsConstructor
public class PtorResponseDTO {
    // 노인 -> 보호자 정보 가져오기
    private Integer id;
    private String name;
    private String phone;
}
