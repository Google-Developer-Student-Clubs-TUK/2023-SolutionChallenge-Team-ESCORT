package com.solution.escort.domain.company.entity;

import com.solution.escort.domain.company.entity.Company;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

import javax.persistence.*;

@Entity
@ToString
@Getter
@Builder
@AllArgsConstructor
@EntityListeners(AutoCloseable.class)
public class CompanyImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String imageUrl;

    @ManyToOne
    @JoinColumn(name = "company_id")
    private Company company;

    public CompanyImage() {

    }
}
