def ansible = [:]
        ansible.name = 'ansible'
        ansible.host = '172.31.14.182'
        ansible.user = 'centos'
        ansible.password = 'Rnstech@123'
        ansible.allowAnyHosts = true
		 
def kops = [:]
        kops.name = 'kops'
        kops.host = '54.255.180.216'
        kops.user = 'centos'
        kops.password = 'Rnstech@123'
        kops.allowAnyHosts = true
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
                sshCommand remote: ansible, command: 'cd Maven-Java-Project; git pull'
                
                sshCommand remote: ansible, command: 'cd Maven-Java-Project; ansible-playbook -i hosts tools/docker/docker-install.yml'   
                      //K8s Setup
                sshCommand remote: kops, command: "cd Maven-Java-Project; git pull"
	        sshCommand remote: kops, command: "kubectl apply -f Maven-Java-Project/k8s-code/staging/namespace/staging-ns.yml"
	        sshCommand remote: kops, command: "kubectl apply -f Maven-Java-Project/k8s-code/prod/namespace/prod-ns.yml"
            }  
       }   			
    } 
}
