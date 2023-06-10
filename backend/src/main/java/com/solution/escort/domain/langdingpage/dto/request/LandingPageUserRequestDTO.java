package com.solution.escort.domain.langdingpage.dto.request;

import com.solution.escort.domain.langdingpage.entity.LandingPageUser;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;


@Data
@NoArgsConstructor
public class LandingPageUserRequestDTO {
    @NotEmpty(message = "이름은 필수 입력 값입니다.")
    private String name;
    @NotEmpty(message = "이메일은 필수 입력 값입니다.")
    @Email(message = "이메일 형식에 맞지 않습니다.")
    private String email;
    private String message;

    public LandingPageUserRequestDTO(LandingPageUser landingPageUser) {
        this.name = landingPageUser.getName();
        this.email = landingPageUser.getEmail();
        this.message = landingPageUser.getMessage();
    }
}
