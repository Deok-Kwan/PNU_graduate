#!/bin/bash

# GitHub-Overleaf 연동 자동 설정 스크립트
# 사용법: ./setup_github.sh [GitHub 저장소 URL]

set -e  # 오류 시 중단

echo "================================================"
echo "학위논문 GitHub 저장소 설정 스크립트"
echo "================================================"
echo ""

# 현재 디렉토리 확인
CURRENT_DIR=$(pwd)
echo "작업 디렉토리: $CURRENT_DIR"
echo ""

# GitHub URL 입력 받기
if [ -z "$1" ]; then
    echo "GitHub 저장소 URL을 입력하세요:"
    echo "(예: https://github.com/yangdeokkwan/thesis.git)"
    read -p "URL: " GITHUB_URL
else
    GITHUB_URL=$1
fi

if [ -z "$GITHUB_URL" ]; then
    echo "❌ 오류: GitHub URL이 필요합니다."
    exit 1
fi

echo "GitHub URL: $GITHUB_URL"
echo ""

# Git이 초기화되어 있는지 확인
if [ -d ".git" ]; then
    echo "⚠️  경고: Git이 이미 초기화되어 있습니다."
    read -p "다시 초기화하시겠습니까? (y/N): " REINIT
    if [ "$REINIT" = "y" ] || [ "$REINIT" = "Y" ]; then
        echo "기존 .git 디렉토리 백업 중..."
        mv .git .git.backup.$(date +%Y%m%d_%H%M%S)
    else
        echo "기존 Git 저장소 유지"
        SKIP_INIT=true
    fi
fi

# Git 초기화
if [ "$SKIP_INIT" != "true" ]; then
    echo ""
    echo "📦 Git 초기화 중..."
    git init
    echo "✅ Git 초기화 완료"
fi

# 빌드 파일 정리
echo ""
echo "🧹 LaTeX 빌드 파일 정리 중..."
rm -f *.aux *.log *.fls *.fdb_latexmk *.synctex.gz *.bbl *.blg *.out *.toc
rm -f .DS_Store
echo "✅ 빌드 파일 정리 완료"

# .gitignore 확인
if [ ! -f ".gitignore" ]; then
    echo "⚠️  경고: .gitignore 파일이 없습니다."
    echo "생성하시겠습니까? (Y/n): "
    read CREATE_GITIGNORE
    if [ "$CREATE_GITIGNORE" != "n" ] && [ "$CREATE_GITIGNORE" != "N" ]; then
        echo "# .gitignore 파일이 필요합니다" > .gitignore
        echo "GITHUB_OVERLEAF_GUIDE.md 파일을 참조하여 수동으로 추가하세요."
    fi
fi

# 파일 추가
echo ""
echo "📝 파일 추가 중..."
git add .

# 커밋
echo ""
echo "커밋 메시지를 입력하세요 (기본값: 'Initial commit: 학위논문 LaTeX 프로젝트'):"
read -p "메시지: " COMMIT_MSG
if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Initial commit: 학위논문 LaTeX 프로젝트"
fi

git commit -m "$COMMIT_MSG"
echo "✅ 커밋 완료"

# Remote 추가
echo ""
echo "🔗 GitHub 저장소 연결 중..."

# 기존 remote 확인
if git remote | grep -q "origin"; then
    echo "⚠️  'origin' remote가 이미 존재합니다."
    EXISTING_URL=$(git remote get-url origin)
    echo "기존 URL: $EXISTING_URL"
    read -p "변경하시겠습니까? (y/N): " CHANGE_REMOTE
    if [ "$CHANGE_REMOTE" = "y" ] || [ "$CHANGE_REMOTE" = "Y" ]; then
        git remote set-url origin "$GITHUB_URL"
        echo "✅ Remote URL 변경 완료"
    fi
else
    git remote add origin "$GITHUB_URL"
    echo "✅ Remote 추가 완료"
fi

# 브랜치 이름 설정
echo ""
echo "🌿 기본 브랜치 설정 중..."
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    git branch -M main
    echo "✅ 브랜치를 'main'으로 변경"
fi

# Push
echo ""
echo "📤 GitHub에 푸시 중..."
read -p "GitHub에 푸시하시겠습니까? (Y/n): " DO_PUSH
if [ "$DO_PUSH" != "n" ] && [ "$DO_PUSH" != "N" ]; then
    git push -u origin main
    echo "✅ 푸시 완료"
else
    echo "⏭️  푸시 생략 (나중에 'git push -u origin main' 실행)"
fi

# 완료 메시지
echo ""
echo "================================================"
echo "✅ 설정 완료!"
echo "================================================"
echo ""
echo "다음 단계:"
echo "1. GitHub 저장소 확인: ${GITHUB_URL%.git}"
echo "2. Overleaf에서 'Import from GitHub' 사용"
echo "3. 자세한 내용은 GITHUB_OVERLEAF_GUIDE.md 참조"
echo ""
echo "유용한 명령어:"
echo "  git status              # 현재 상태 확인"
echo "  git add .               # 변경사항 추가"
echo "  git commit -m '메시지'  # 커밋"
echo "  git push                # GitHub에 푸시"
echo "  git pull                # GitHub에서 가져오기"
echo ""
