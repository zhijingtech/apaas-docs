--1、创建一个日志表 ：首先，创建一个表来存储所有的变化日志。
CREATE TABLE change_log (
    id SERIAL PRIMARY KEY,
    operation_type VARCHAR(10),
    table_name VARCHAR(50),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSONB,
    new_data JSONB
);

--2、创建一个通用触发器函数 ：这个函数将会在每次表数据变化时被调用，并记录变化。
CREATE OR REPLACE FUNCTION log_table_changes() RETURNS TRIGGER AS $$
DECLARE
    operation_type VARCHAR(10);
    old_row JSONB;
    new_row JSONB;
BEGIN
    -- Determine the type of operation
    IF (TG_OP = 'INSERT') THEN
        operation_type := 'INSERT';
        new_row := row_to_json(NEW);
    ELSIF (TG_OP = 'UPDATE') THEN
        operation_type := 'UPDATE';
        old_row := row_to_json(OLD);
        new_row := row_to_json(NEW);
    ELSIF (TG_OP = 'DELETE') THEN
        operation_type := 'DELETE';
        old_row := row_to_json(OLD);
    END IF;

    -- Insert the change log
    INSERT INTO change_log (operation_type, table_name, old_data, new_data)
    VALUES (operation_type, TG_TABLE_NAME, old_row, new_row);

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--3、为每个表创建触发器 ：为你想要监听的每个表创建一个触发器。
CREATE TRIGGER trigger_continuity_containers AFTER INSERT OR UPDATE OR DELETE ON continuity_containers FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_courier_message_dispatches AFTER INSERT OR UPDATE OR DELETE ON courier_message_dispatches FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_courier_messages AFTER INSERT OR UPDATE OR DELETE ON courier_messages FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_client AFTER INSERT OR UPDATE OR DELETE ON hydra_client FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_jwk AFTER INSERT OR UPDATE OR DELETE ON hydra_jwk FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_access AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_access FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_authentication_session AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_authentication_session FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_code AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_code FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_flow AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_flow FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_jti_blacklist AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_jti_blacklist FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_logout_request AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_logout_request FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_obfuscated_authentication_session AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_obfuscated_authentication_session FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_oidc AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_oidc FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_pkce AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_pkce FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_refresh AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_refresh FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_hydra_oauth2_trusted_jwt_bearer_issuer AFTER INSERT OR UPDATE OR DELETE ON hydra_oauth2_trusted_jwt_bearer_issuer FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identities AFTER INSERT OR UPDATE OR DELETE ON identities FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_credential_identifiers AFTER INSERT OR UPDATE OR DELETE ON identity_credential_identifiers FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_credential_types AFTER INSERT OR UPDATE OR DELETE ON identity_credential_types FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_credentials AFTER INSERT OR UPDATE OR DELETE ON identity_credentials FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_login_codes AFTER INSERT OR UPDATE OR DELETE ON identity_login_codes FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_recovery_addresses AFTER INSERT OR UPDATE OR DELETE ON identity_recovery_addresses FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_recovery_codes AFTER INSERT OR UPDATE OR DELETE ON identity_recovery_codes FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_recovery_tokens AFTER INSERT OR UPDATE OR DELETE ON identity_recovery_tokens FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_registration_codes AFTER INSERT OR UPDATE OR DELETE ON identity_registration_codes FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_verifiable_addresses AFTER INSERT OR UPDATE OR DELETE ON identity_verifiable_addresses FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_verification_codes AFTER INSERT OR UPDATE OR DELETE ON identity_verification_codes FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_identity_verification_tokens AFTER INSERT OR UPDATE OR DELETE ON identity_verification_tokens FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_keto_relation_tuples AFTER INSERT OR UPDATE OR DELETE ON keto_relation_tuples FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_keto_uuid_mappings AFTER INSERT OR UPDATE OR DELETE ON keto_uuid_mappings FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_networks AFTER INSERT OR UPDATE OR DELETE ON networks FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_selfservice_errors AFTER INSERT OR UPDATE OR DELETE ON selfservice_errors FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_selfservice_login_flows AFTER INSERT OR UPDATE OR DELETE ON selfservice_login_flows FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_selfservice_recovery_flows AFTER INSERT OR UPDATE OR DELETE ON selfservice_recovery_flows FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_selfservice_registration_flows AFTER INSERT OR UPDATE OR DELETE ON selfservice_registration_flows FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_selfservice_settings_flows AFTER INSERT OR UPDATE OR DELETE ON selfservice_settings_flows FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_selfservice_verification_flows AFTER INSERT OR UPDATE OR DELETE ON selfservice_verification_flows FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_session_devices AFTER INSERT OR UPDATE OR DELETE ON session_devices FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_session_token_exchanges AFTER INSERT OR UPDATE OR DELETE ON session_token_exchanges FOR EACH ROW EXECUTE FUNCTION log_table_changes();
CREATE TRIGGER trigger_sessions AFTER INSERT OR UPDATE OR DELETE ON sessions FOR EACH ROW EXECUTE FUNCTION log_table_changes();