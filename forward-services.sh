#!/bin/bash
# forward-services.sh

NAMESPACE="product-app"

echo "Forwarding database-service on localhost:5432..."
kubectl port-forward svc/database-service 5432:5432 -n $NAMESPACE >/dev/null 2>&1 &
DB_PID=$!

echo "Forwarding redisinsight-service on localhost:8001..."
kubectl port-forward svc/redisinsight-service 8001:8001 -n $NAMESPACE >/dev/null 2>&1 &
REDIS_PID=$!

echo "Services forwarded!"
echo "Database:   http://localhost:5432"
echo "RedisInsight: http://localhost:8001"
echo ""
echo "Press CTRL+C to stop port-forwarding."

# Keep the script running to keep the port-forwards alive
wait $DB_PID $REDIS_PID
