#!/bin/bash


# Apply the configuration to the containers
running_containers=$(docker ps -q)
if [[ ! -z $running_containers ]]; then
    for i in ${running_containers[@]}; do
        container_info=$(echo "$i:$(docker exec $i hostname)")
        hostname=${container_info#*:}
        container_id=${container_info%:*}
        case $hostname in
            host_jnguyen-*|router_jnguyen-*)
                filename="$hostname"
                docker cp "./confs/$filename" "$container_id:/"
                docker exec "$container_id" ash "/$filename"
                echo "Configuration is applied on $container_id running the $hostname"
                ;;
        esac
    done
    exit 0
else
    echo "No running containers"
    exit 1
fi
