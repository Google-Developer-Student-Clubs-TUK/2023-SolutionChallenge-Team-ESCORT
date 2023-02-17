package com.solution.escort.domain.protector.repository;

import com.solution.escort.domain.protector.entity.Protector;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProtectorRepository extends JpaRepository<Protector, Integer> {
    boolean existsByEmail(String email);
}
