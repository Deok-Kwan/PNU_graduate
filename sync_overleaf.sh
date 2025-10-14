#!/bin/bash

# Overleaf Free 동기화 스크립트
# 사용법: ./sync_overleaf.sh [push|pull|both]

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Overleaf Git URL (여기에 실제 URL 입력)
OVERLEAF_URL="https://git.overleaf.com/YOUR_PROJECT_ID"  # TODO: 실제 URL로 변경

echo "🔄 Overleaf 동기화 스크립트"
echo "========================="

# Overleaf remote가 있는지 확인
if ! git remote | grep -q "overleaf"; then
    echo -e "${YELLOW}⚠️  Overleaf remote가 없습니다. 추가하는 중...${NC}"
    if [ "$OVERLEAF_URL" = "https://git.overleaf.com/YOUR_PROJECT_ID" ]; then
        echo -e "${RED}❌ 먼저 OVERLEAF_URL을 실제 URL로 변경해주세요!${NC}"
        echo "   파일 수정: $0"
        echo "   라인 11에서 YOUR_PROJECT_ID를 실제 ID로 변경"
        exit 1
    fi
    git remote add overleaf "$OVERLEAF_URL"
    echo -e "${GREEN}✅ Overleaf remote 추가 완료${NC}"
fi

# 작업 선택
ACTION=${1:-both}

case $ACTION in
    push)
        echo -e "\n${YELLOW}📤 GitHub → Overleaf 푸시${NC}"
        echo "GitHub의 최신 변경사항을 Overleaf로 보냅니다..."

        # GitHub에서 최신 변경사항 가져오기
        echo "1. GitHub에서 최신 버전 가져오기..."
        git pull origin main

        # Overleaf로 푸시
        echo "2. Overleaf로 푸시..."
        git push overleaf main:master

        echo -e "${GREEN}✅ 푸시 완료!${NC}"
        echo "Overleaf 웹사이트에서 새로고침하면 변경사항이 보입니다."
        ;;

    pull)
        echo -e "\n${YELLOW}📥 Overleaf → GitHub 가져오기${NC}"
        echo "Overleaf의 최신 변경사항을 가져옵니다..."

        # Overleaf에서 가져오기
        echo "1. Overleaf에서 변경사항 가져오기..."
        git fetch overleaf

        # 병합
        echo "2. 변경사항 병합..."
        git merge overleaf/master --allow-unrelated-histories

        # GitHub에 푸시
        echo "3. GitHub에 푸시..."
        git push origin main

        echo -e "${GREEN}✅ 가져오기 완료!${NC}"
        echo "GitHub에 Overleaf 변경사항이 백업되었습니다."
        ;;

    both)
        echo -e "\n${YELLOW}🔄 양방향 동기화${NC}"

        # 먼저 Overleaf에서 가져오기
        echo "1. Overleaf에서 변경사항 확인..."
        git fetch overleaf

        # GitHub에서도 가져오기
        echo "2. GitHub에서 변경사항 확인..."
        git fetch origin

        # 병합 시도
        echo "3. 변경사항 병합..."
        git pull origin main
        git pull overleaf master --allow-unrelated-histories

        # 양쪽에 푸시
        echo "4. 양쪽에 푸시..."
        git push origin main
        git push overleaf main:master

        echo -e "${GREEN}✅ 양방향 동기화 완료!${NC}"
        ;;

    *)
        echo "사용법: $0 [push|pull|both]"
        echo "  push - GitHub → Overleaf"
        echo "  pull - Overleaf → GitHub"
        echo "  both - 양방향 동기화 (기본값)"
        exit 1
        ;;
esac

# 현재 상태 표시
echo -e "\n📊 현재 상태:"
echo "-------------"
git status --short

echo -e "\n💡 팁:"
echo "- Overleaf에서 편집 후: ./sync_overleaf.sh pull"
echo "- 로컬에서 편집 후: ./sync_overleaf.sh push"
echo "- 잘 모르겠을 때: ./sync_overleaf.sh both"