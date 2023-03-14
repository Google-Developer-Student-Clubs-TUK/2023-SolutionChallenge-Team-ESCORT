package com.solution.escort.domain.protector.dto.request;

import com.solution.escort.domain.protector.entity.Protector;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

@AllArgsConstructor
@Builder
@Getter
@Setter
@Slf4j
@NoArgsConstructor
public class ProtectorRequestDTO {
    private String email;
    private String password;
    private String name;
    private String phone;
    private String address;
    private String deviceToken;
    private MultipartFile profileImage;

    private String uId;

    public Protector toProtectorEntity(ProtectorRequestDTO protectorRequestDTO){
        return Protector.builder()
                .email(protectorRequestDTO.getEmail())
                .password(protectorRequestDTO.getPassword())
                .name(protectorRequestDTO.getName())
                .phone(protectorRequestDTO.getPhone())
                .address(protectorRequestDTO.getAddress())
                .deviceToken(protectorRequestDTO.getDeviceToken())
                .uId(protectorRequestDTO.getUId())
                .build();
    }
}
