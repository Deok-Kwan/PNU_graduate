# Overleaf Free 동기화 가이드

## 🔗 Overleaf Git URL 설정하기

1. Overleaf.com 접속 → 프로젝트 열기
2. Menu → Git → Clone With Git
3. 나타나는 URL 복사 (예: `https://git.overleaf.com/1234567890abcdef`)

## 🚀 빠른 명령어

### 초기 설정 (한 번만)
```bash
# Overleaf remote 추가
git remote add overleaf https://git.overleaf.com/YOUR_PROJECT_ID
```

### 일상 작업

#### 📤 GitHub → Overleaf (로컬에서 작업 후)
```bash
# 방법 1: 스크립트 사용
./sync_overleaf.sh push

# 방법 2: 수동 명령어
git push overleaf main:master
```

#### 📥 Overleaf → GitHub (Overleaf에서 작업 후)
```bash
# 방법 1: 스크립트 사용
./sync_overleaf.sh pull

# 방법 2: 수동 명령어
git pull overleaf master
git push origin main
```

#### 🔄 양방향 동기화 (안전)
```bash
./sync_overleaf.sh both
```

## ⚠️ 주의사항

### Overleaf Free 제한사항
- ❌ 자동 동기화 없음 (수동으로 해야 함)
- ❌ 협업자 1명만 가능
- ❌ Git 히스토리 제한적

### 충돌 해결
```bash
# 충돌 발생 시
git status  # 충돌 파일 확인
# 파일 수정 후
git add .
git commit -m "충돌 해결"
git push origin main
git push overleaf main:master
```

## 📅 추천 워크플로우

### 아침 루틴
```bash
# Overleaf 변경사항 가져오기
git pull overleaf master
git push origin main  # GitHub 백업
```

### 저녁 루틴
```bash
# 로컬 작업 Overleaf로 보내기
git add .
git commit -m "오늘 작업 내용"
git push origin main     # GitHub 백업
git push overleaf main:master  # Overleaf 업데이트
```

### 주간 백업
```bash
# 전체 동기화 및 태그
./sync_overleaf.sh both
git tag -a "week-$(date +%V)" -m "$(date +%Y년 %m월 %d주차) 백업"
git push --tags
```

## 🆘 문제 해결

### "rejected" 에러
```bash
# Overleaf가 더 최신일 때
git pull overleaf master --allow-unrelated-histories
git push overleaf main:master --force-with-lease
```

### 인증 문제
```bash
# Overleaf 비밀번호 재입력
git remote remove overleaf
git remote add overleaf https://git.overleaf.com/YOUR_PROJECT_ID
```

### 브랜치 이름 문제
```bash
# Overleaf는 'master', GitHub은 'main' 사용
git push overleaf main:master  # main을 master로 푸시
git pull overleaf master:main  # master를 main으로 가져오기
```

## 💡 유용한 팁

1. **컴파일 전 동기화**: Overleaf에서 컴파일 전에 항상 pull
2. **정기 백업**: 매일 저녁 GitHub에 백업
3. **태그 활용**: 중요한 버전에 태그 추가
4. **로그 확인**: `git log --oneline -10` 으로 최근 변경사항 확인

## 📊 상태 확인 명령어

```bash
# 모든 remote 확인
git remote -v

# 브랜치 상태
git branch -a

# 최근 커밋
git log --oneline -5

# 동기화 상태
git fetch --all
git status
```