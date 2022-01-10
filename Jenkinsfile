def ansible = [:]
         ansible.name = 'ansible'
         ansible.host = '172.31.14.182'
         ansible.user = 'centos'
         ansible.password = 'Rnstech@123'
         ansible.allowAnyHosts = true
pipeline {
    agent { label 'BuildServer'}

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven3.8"
    }

    stages{
        stage('Build') {
            steps{
                git credentialsId: 'github', url: 'https://github.com/kprasanth999/Maven-Java-Project.git'    
	        	sh "mvn clean package"  
	    }
            post{
                success{
                junit 'target/surefire-reports/*.xml'
                archiveArtifacts artifacts: '**/*.war', followSymlinks: false
                }
            }   
	}
        stage('Tools Setup'){
            steps{
                echo "Tools Setup"
                sshCommand remote: ansible, command: 'cd Maven-Java-Project; git pull origin master'
                sshCommand remote: ansible, command: 'cd Maven-Java-Project; ansible-playbook -i hosts tools/sonarqube/sonar-install.yaml'
                sshCommand remote: ansible, command: 'cd Maven-Java-Project; ansible-playbook -i hosts tools/docker/docker-install.yml'   
            }   			
        } 
    }        
}
