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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String characteristic;

    @Column(nullable = false)
    private String bloodType;

    @Column(nullable = false)
    private String phone;

    @Column
    private String clothing;

    @Column(nullable = false)
    private String deviceToken;

    @Column(nullable = false)
    private int scope;

    @Column
    private boolean state = true;

    @Column
    private String imageUrl;

    @ColumnDefault("82")
    private String countryCode;

    @Column(nullable = false)
    private String fbId;

    @Column(nullable = false)
    private String birth;


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
                .uId(protege.getFbId())
                .clothing(protege.getClothing())
                .birth(protege.getBirth())
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
                .countryCode(protege.getCountryCode())
                .clothing(protege.getClothing())
                .uId(protege.getFbId())
                .age(getWorldAge(protege.getBirth()))
                .build();
    }

    public static int getWorldAge(String birthDate) {
        LocalDate now = LocalDate.now();
        LocalDate parsedBirthDate = LocalDate.parse(birthDate, DateTimeFormatter.ofPattern("yyyyMMdd"));

        int americanAge = now.minusYears(parsedBirthDate.getYear()).getYear(); // (1)

        // (2)
        // 생일이 지났는지 여부를 판단하기 위해 (1)을 입력받은 생년월일의 연도에 더한다.
        // 연도가 같아짐으로 생년월일만 판단할 가능
        if (parsedBirthDate.plusYears(americanAge).isAfter(now)) {
            americanAge = americanAge -1;
        }
        return americanAge;
    }
}
