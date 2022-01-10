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
}
