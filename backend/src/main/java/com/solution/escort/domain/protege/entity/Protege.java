package com.solution.escort.domain.protege.entity;

import com.solution.escort.domain.PPConnection.dto.response.PgeResponseDTO;
import com.solution.escort.domain.PPConnection.entity.ProtectorProtege;
import com.solution.escort.domain.protege.dto.response.ProtegeResponseDTO;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@DynamicInsert
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class Protege {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String name;

    @Column
    private String email;

    @Column
    private String password;

    @Column
    private String characteristic;

    @Column
    private String bloodType;

    @Column
    private String phone;

    @Column
    private String clothing;

    @Column
    @CreatedDate
    private LocalDateTime createdAt;

    @Column
    private String deviceToken;

    @Column
    private int scope;

    @Column
    private boolean state = true;

    @Column
    private String imageUrl;

    @ColumnDefault("82")
    private String countryCode;

    @Column
    private String uId;


    @OneToMany(mappedBy = "protege")
    private List<ProtectorProtege> protectors = new ArrayList<>();


    public ProtegeResponseDTO toProtegeResponseDTO(Protege protege, List<String> safeZones) {
        return ProtegeResponseDTO.builder()
                .id(protege.getId())
                .email(protege.getEmail())
                .name(protege.getName())
                .characteristic(protege.getCharacteristic())
                .bloodType(protege.getBloodType())
                .phone(protege.getPhone())
                .safeZones(safeZones)
                .deviceToken(protege.getDeviceToken())
                .countryCode(protege.getCountryCode())
                .scope(protege.getScope())
                .imageUrl(protege.getImageUrl())
                .uId(protege.getUId())
                .build();
    }

    // uid 추가 필요할수도
    public PgeResponseDTO toPgResponseDTO(Protege protege, List<String> safeZones) {
        return PgeResponseDTO.builder()
                .id(protege.getId())
                .email(protege.getEmail())
                .name(protege.getName())
                .characteristic(protege.getCharacteristic())
                .bloodType(protege.getBloodType())
                .phone(protege.getPhone())
                .safeZones(safeZones)
                .imageUrl(protege.getImageUrl())
                .build();
    }
}
