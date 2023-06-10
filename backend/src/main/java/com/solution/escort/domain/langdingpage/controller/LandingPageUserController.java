package com.solution.escort.domain.langdingpage.controller;

import com.solution.escort.domain.langdingpage.dto.request.LandingPageUserRequestDTO;
import com.solution.escort.domain.langdingpage.entity.LandingPageUser;
import com.solution.escort.domain.langdingpage.service.LandingPageUserService;
import com.solution.escort.global.ResponseFormat;
import com.solution.escort.global.ResponseStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;


@Controller
@RequiredArgsConstructor
public class LandingPageUserController {

    private final LandingPageUserService landingPageUserService;

    @PostMapping("/api/v1/landingpageusers")

    public ResponseEntity<ResponseFormat<LandingPageUserRequestDTO>> createUser(@RequestBody @Valid LandingPageUserRequestDTO landingPageUserRequestDTO
    ){

        LandingPageUser landingPageUser = mapToLandingPageUser(landingPageUserRequestDTO);
        landingPageUserService.createLandingPageUser(landingPageUser);

        ResponseFormat<LandingPageUserRequestDTO> responseFormat =
                new ResponseFormat<>(ResponseStatus.POST_LANDING_USER_SUCCESS);

        return ResponseEntity.status(HttpStatus.OK).body(responseFormat);
    }

    private LandingPageUser mapToLandingPageUser(LandingPageUserRequestDTO requestDTO){
        LandingPageUser landingPageUser = new LandingPageUser();
        landingPageUser.setName(requestDTO.getName());
        landingPageUser.setEmail(requestDTO.getEmail());
        landingPageUser.setMessage(requestDTO.getMessage());
        return landingPageUser;
    }








}
