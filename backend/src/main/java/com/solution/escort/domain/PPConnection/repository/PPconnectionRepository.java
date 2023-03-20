package com.solution.escort.domain.PPConnection.repository;

import com.solution.escort.domain.PPConnection.dto.response.PgeResponseDTO;
import com.solution.escort.domain.PPConnection.entity.ProtectorProtege;
import com.solution.escort.domain.protege.entity.Protege;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

public interface PPconnectionRepository extends JpaRepository<ProtectorProtege, Integer> {
    @Query(value = "select protege_id from protector_protege where protector_id= (:protectorId)", nativeQuery = true)
    public List<Integer> findProtegeIdByOrderByProtectorIdDesc(@Param("protectorId") Integer protector_id);

    @Query(value = "select protector_id from protector_protege where protege_id= (:protegeId)", nativeQuery = true)
    public List<Integer> findProtectorIdByOrderByProtegeIdDesc(@Param("protegeId") Integer protege_id);


}
