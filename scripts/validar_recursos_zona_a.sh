vpc_id=$(aws ec2 describe-vpcs --filters Name=isDefault,Values=true --query "Vpcs[0].VpcId" --output text 2>/dev/null)
if [ $? -eq 0 ]; then
  echo "[OK] Tudo certo com a VPC"
else
  echo ">[ERRO] Tenho um problema ao retornar a VPC default. Será se ela existe?"
fi

subnet_id=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=$vpc_id Name=availabilityZone,Values=us-east-1a --query "Subnets[0].SubnetId" --output text 2>/dev/null)
if [ $? -eq 0 ]; then
  echo "[OK] Tudo certo com a Subnet"
else
  echo ">[ERRO] Tenho um problema ao retornar a subnet da zona a. Será se existe uma subnet na zona A?"
fi

# Buscar o ID do security group 'bia-dev'
security_group_id=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=bia-dev" --query "SecurityGroups[0].GroupId" --output text 2>/dev/null)

if [ $? -eq 0 ] && [ -n "$security_group_id" ]; then
  echo "[OK] Security Group 'bia-dev' foi encontrado com ID $security_group_id"
  
  # Validar inbound rule para o security group 'bia-dev'
  inbound_rule=$(aws ec2 describe-security-groups --group-ids $security_group_id --filters "Name=ip-permission.from-port,Values=3001" "Name=ip-permission.cidr,Values=0.0.0.0/0" --query "SecurityGroups[0].IpPermissions" --output text)

  if [ -n "$inbound_rule" ]; then
    echo "[OK] Regra de entrada para a porta 3001 está correta"
  else
    echo "[ERRO] Regra de entrada para a porta 3001 não encontrada ou não está aberta para o mundo todo. Reveja a aula do Henrylle"
  fi

  # Validar outbound rule para o security group 'bia-dev'
  outbound_rule=$(aws ec2 describe-security-groups --group-ids $security_group_id --query "SecurityGroups[0].IpPermissionsEgress[?IpProtocol=='-1' && IpRanges[0].CidrIp=='0.0.0.0/0']" --output text)
  
  if [ -n "$outbound_rule" ]; then
    echo "[OK] Regra de saída está correta"
  else
    echo "[ERRO] Regra de saída para o mundo não encontrada. Reveja a aula do Henrylle"
  fi
else
  echo "[ERRO] Não achei o security group 'bia-dev'. Ele foi criado?"
fi


if aws iam get-role --role-name role-acesso-ssm &>/dev/null; then
    echo "[OK] Tudo certo com a role 'role-acesso-ssm'"
else
    echo ">[ERRO] A role 'role-acesso-ssm' não existe"
fi
