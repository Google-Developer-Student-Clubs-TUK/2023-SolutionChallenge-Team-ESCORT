package com.solution.escort.domain.protector.dto.response;

import lombok.*;
import lombok.extern.slf4j.Slf4j;

@AllArgsConstructor
@Builder
@Getter
@ToString
@Setter
@Slf4j
@NoArgsConstructor
public class ProtectorResponseDTO {
    private Integer id;
    private String email;
    private String name;
    private String phone;
    private String address;
    private String countryCode;
    private String deviceToken;
    private String imageUrl;
    private String uId;

}
