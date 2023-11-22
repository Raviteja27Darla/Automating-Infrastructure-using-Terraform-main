pipeline {
    agent any 
    
    tools {
        maven 'maven 3'
    }
    parameters {
        string defaultValue: 'Raviteja', name: 'employeeIDName'
    }
    stages{
        stage('CheckOut'){
            steps{
                checkout poll: false, scm: scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/RAVITEJADARLA/Sample-Project-1.git']])
            }
        }
        stage('Build'){
            steps{  
                echo "Build Stage"
                sh 'mvn compile'
            }
        }
        stage('Unit Test'){
            steps{
                echo "Testing Stage"
                sh 'mvn test'
            }
        }
        stage('xml File Junit'){
            steps{
                junit 'target/surefire-reports/TEST-JenkinsDemoTest.xml' 
                junit 'target/surefire-reports/TEST-com.vcjain.calculator.OperationsTest.xml'
            }
        }
        stage('Installation'){
            steps{
                echo "Installation Stage"
                sh 'mvn install'
            }
        }
        stage ('Jar File'){
            steps{
                echo "Jar File Generate"
                archiveArtifacts artifacts: 'target/calculator-0.0.1-SNAPSHOT.jar', followSymlinks: false 
            }
        }
        stage('Employee Name'){
            steps{
                echo "${params.employeeIDName}"
            }
        }
    }
}
