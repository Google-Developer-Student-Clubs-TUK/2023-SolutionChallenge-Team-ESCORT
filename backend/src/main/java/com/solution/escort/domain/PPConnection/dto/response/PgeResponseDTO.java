package com.solution.escort.domain.PPConnection.dto.response;

import com.solution.escort.domain.protege.entity.Protege;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@Builder
@Getter
@ToString
@Setter
@Slf4j
@NoArgsConstructor
public class PgeResponseDTO {
    // 보호자 -> 노인 정보 가져오기
    private Integer id;
    private String email;
    private String name;
    private String characteristic;
    private String bloodType;
    private String phone;
    private String imageUrl;
    private List<String> safeZones;
}
