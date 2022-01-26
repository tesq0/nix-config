function delete-all-containers --description 'delete all current docker containers'
	docker stop (docker ps -a -q)
	docker rm (docker ps -a -q)
end
