CREATE INDEX idx_encounter_type_form_id_voided_datetime ON encounter (encounter_type, form_id, voided, encounter_datetime);
CREATE INDEX idx_concept_id_voided ON obs (concept_id, voided);
CREATE INDEX idx_concept_id_obs_group_id_voided ON obs (concept_id, obs_group_id, voided);
CREATE INDEX idx_concept_id_value_numeric_voided ON obs (concept_id, value_numeric, voided);