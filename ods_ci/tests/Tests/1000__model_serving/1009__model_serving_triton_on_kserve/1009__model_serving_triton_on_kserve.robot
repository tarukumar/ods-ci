*** Settings ***
Documentation     Suite of test cases for Triton in Kserve
Library           OperatingSystem
Library           ../../../../libs/Helpers.py
Resource          ../../../Resources/Page/ODH/JupyterHub/HighAvailability.robot
Resource          ../../../Resources/Page/ODH/ODHDashboard/ODHModelServing.resource
Resource          ../../../Resources/Page/ODH/ODHDashboard/ODHDataScienceProject/Projects.resource
Resource          ../../../Resources/Page/ODH/ODHDashboard/ODHDataScienceProject/DataConnections.resource
Resource          ../../../Resources/Page/ODH/ODHDashboard/ODHDataScienceProject/ModelServer.resource
Resource          ../../../Resources/Page/ODH/ODHDashboard/ODHDashboardSettingsRuntimes.resource
Resource          ../../../Resources/Page/ODH/Monitoring/Monitoring.resource
Resource          ../../../Resources/OCP.resource
Resource          ../../../Resources/CLI/ModelServing/modelmesh.resource
Suite Setup       Triton On Kserve Suite Setup
#Suite Teardown    Triton On Kserve Suite Teardown
Test Tags         Kserve

*** Variables ***
${INFERENCE_REST_INPUT_ONNX}=    @tests/Resources/Files/triton/kserve-triton-onnx-gRPC-input.json
${PRJ_TITLE}=    model-serving-triton-project1
${PRJ_DESCRIPTION}=    project used for model serving triton runtime tests
${MODEL_CREATED}=    ${FALSE}
${MODEL_NAME}=    densenet_onnx
${MODEL_LABEL}=     densenetonnx
${RUNTIME_NAME}=    triton-kserve-grpc
${RESOURCES_DIRPATH}=        tests/Resources/Files/triton
${TRITON_RUNTIME_FILEPATH}=    ${RESOURCES_DIRPATH}/triton_onnx_gRPC_servingruntime.yaml
${EXPECTED_INFERENCE_REST_OUTPUT_ONNX}=        {"outputs":[{"shape":["1000"],"parameters":{},"name":"fc6_1","datatype":"FP32","contents":null}],"raw_output_contents":["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"],"parameters":{},"model_name":"densenet_onnx","model_version":"1","id":"test1"}

*** Test Cases ***
Test Onnx Model gRPC Inference Via UI (Triton on Kserve)
    [Documentation]    Test the deployment of an onnx model in Kserve using Triton
    [Tags]    Sanity    Tier1       RunThisTest

    Open Data Science Projects Home Page
    Create Data Science Project    title=${PRJ_TITLE}    description=${PRJ_DESCRIPTION}
    ...    existing_project=${FALSE}
    Open Dashboard Settings    settings_page=Serving runtimes
    Upload Serving Runtime Template    runtime_filepath=${TRITON_RUNTIME_FILEPATH}
    ...    serving_platform=single     runtime_protocol=gRPC
    Serving Runtime Template Should Be Listed    displayed_name=${RUNTIME_NAME}
    ...    serving_platform=single
    Recreate S3 Data Connection    project_title=${PRJ_TITLE}    dc_name=model-serving-connection
    ...            aws_access_key=${S3.AWS_ACCESS_KEY_ID}    aws_secret_access=${S3.AWS_SECRET_ACCESS_KEY}
    ...            aws_bucket_name=ods-ci-s3
    Deploy Kserve Model Via UI    model_name=${MODEL_NAME}    serving_runtime=triton-kserve-grpc
    ...    data_connection=model-serving-connection    path=triton/model_repository/    model_framework=onnx - 1
    Wait For Pods To Be Ready    label_selector=serving.kserve.io/inferenceservice=${MODEL_LABEL}
    ...    namespace=${PRJ_TITLE}
    Run Keyword And Continue On Failure    Verify Model Inference With Retries
    ...    ${MODEL_NAME}    ${INFERENCE_REST_INPUT_ONNX}    ${EXPECTED_INFERENCE_REST_OUTPUT_ONNX}    token_auth=${FALSE}
    ...    project_title=${PRJ_TITLE}
    #[Teardown]    Run Keywords    Clean All Models Of Current User    AND
    #...    Run Keyword If Test Failed    Get Kserve Events And Logs
    #...    model_name=${MODEL_NAME}    project_title=${PRJ_TITLE}

*** Keywords ***
Triton On Kserve Suite Setup
    [Documentation]    Suite setup steps for testing Triton. It creates some test variables
    ...                and runs RHOSi setup
    Set Library Search Order    SeleniumLibrary
    Skip If Component Is Not Enabled    kserve
    RHOSi Setup

    Launch Dashboard    ${TEST_USER.USERNAME}    ${TEST_USER.PASSWORD}    ${TEST_USER.AUTH_TYPE}
    ...    ${ODH_DASHBOARD_URL}    ${BROWSER.NAME}    ${BROWSER.OPTIONS}

    Fetch Knative CA Certificate    filename=openshift_ca_istio_knative.crt
    Clean All Models Of Current User



Triton On Kserve Suite Teardown
    [Documentation]    Suite teardown steps after testing DSG. It Deletes
    ...                all the DS projects created by the tests and run RHOSi teardown
    # Even if kw fails, deleting the whole project will also delete the model
    # Failure will be shown in the logs of the run nonetheless
    IF    ${MODEL_CREATED}
        Clean All Models Of Current User
    ELSE
       Log    Model not deployed, skipping deletion step during teardown    console=true
    END
    ${projects}=    Create List    ${PRJ_TITLE}
    Delete List Of Projects Via CLI   ocp_projects=${projects}
    # Will only be present on SM cluster runs, but keyword passes
    # if file does not exist
    Remove File    openshift_ca_istio_knative.crt
    SeleniumLibrary.Close All Browsers
    RHOSi Teardown
