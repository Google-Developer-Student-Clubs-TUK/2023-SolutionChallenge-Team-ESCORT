package com.solution.escort.domain.protege.dto.request;

import com.solution.escort.domain.protege.entity.Protege;
import com.solution.escort.domain.protege.entity.SafeZone;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.Column;
import java.util.List;

@AllArgsConstructor
@Builder
@Getter
@Setter
@Slf4j
@NoArgsConstructor
public class ProtegeRequestDTO {
    private String email;
    private String password;
    private String name;
    private String characteristic;
    private String bloodType;
    private String phone;
    private String deviceToken;
    private int scope;
    private MultipartFile profileImage;
    private String countryCode;

    private List<SafeZone> safeZoneAddress;

    public Protege toProtegeEntity(ProtegeRequestDTO protegeRequestDTO) {
        return Protege.builder()
                .email(protegeRequestDTO.getEmail())
                .password(protegeRequestDTO.getPassword())
                .name(protegeRequestDTO.getName())
                .characteristic(protegeRequestDTO.getCharacteristic())
                .bloodType(protegeRequestDTO.getBloodType())
                .phone(protegeRequestDTO.getPhone())
                .deviceToken(protegeRequestDTO.getDeviceToken())
                .scope(protegeRequestDTO.getScope())
                .build();
    }
}
