package com.solution.escort.domain.protege.dto.response;

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
public class ProtegeResponseDTO {
    private Integer id;
    private String email;
    private String name;
    private String characteristic;
    private String bloodType;
    private String phone;
    private LocalDateTime createdAt;
    // 옷차림 수정에서 필요할 시 가져올 예정
    //private String clothing;
    private List<String> safeZones;
    private String countryCode;
    private String deviceToken;
    private int scope;
    private String imageUrl;

    private String uId;

}
