import os
import subprocess
import pytest

# Fixture to run the script and capture output
@pytest.fixture(scope="module")
def run_script():
    script_path = "/root/project/deploy_website.sh"
    process = subprocess.Popen(["bash", script_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    return stdout.decode(), stderr.decode(), process.returncode


def test_directory_creation(run_script):
    stdout, stderr, returncode = run_script
    assert returncode == 0
    assert os.path.isdir("test_directory")


def test_file_creation(run_script):
    stdout, stderr, returncode = run_script
    assert returncode == 0
    assert os.path.isfile("index.php")
    assert os.path.isfile("Dockerfile")


def test_docker_image_build(run_script):
    stdout, stderr, returncode = run_script
    assert returncode == 0
    assert "Successfully built" in stdout
    assert "Successfully tagged" in stdout


def test_docker_image_push(run_script):
    stdout, stderr, returncode = run_script
    assert returncode == 0
    assert "Successfully pushed" in stdout


def test_kubernetes_deployment(run_script):
    stdout, stderr, returncode = run_script
    assert returncode == 0
    assert os.path.isfile("deployment.yaml")
    assert "deployment.apps" in stdout
    assert "service" in stdout


def test_html_file_content(run_script):
    stdout, stderr, returncode = run_script
    assert returncode == 0
    with open("index.php", "r") as f:
        content = f.read()
    assert "<?php" in content
    assert "<!DOCTYPE html>" in content


def test_edge_cases(run_script):
    stdout, stderr, returncode = run_script
    assert returncode == 0
    # Test case for directory name not provided
    assert "Please provide a name for the new directory" in stderr

    # Test case for file name or content not provided
    assert "Please provide both file name and content" in stdout

    # Test case for Docker Hub repository name not provided
    assert "Please provide a name for Docker Hub repository" in stderr

    # Test case for NodePort value not provided
    assert "Please provide a NodePort value" in stderr

    # Test case for Dockerfile creation failure
    assert "Error creating Dockerfile" not in stderr

    # Test case for Docker image build failure
    assert "Error building Docker image" not in stderr

    # Test case for Docker image push failure
    assert "Error pushing Docker image to Docker Hub" not in stderr

    # Test case for Kubernetes deployment failure
    assert "Error applying Kubernetes deployment" not in stderr

    # Test case for final output URL
    assert "The link is http://10.0.0.8:" in stdout
