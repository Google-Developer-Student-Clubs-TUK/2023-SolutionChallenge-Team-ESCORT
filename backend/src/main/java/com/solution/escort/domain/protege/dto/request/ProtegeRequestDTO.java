package com.solution.escort.domain.protege.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Builder
@Getter
@ToString
public class ProtegeRequestDTO {
    private String email;
    private String password;
    private String name;
    private String profileImageUrl;
    private String characteristic;
    private String bloodType;
    private String phone;
    private String address;
}
