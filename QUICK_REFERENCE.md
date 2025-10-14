# 빠른 참조 가이드 (Quick Reference)

## 🚀 빠른 시작 (1분)

### 방법 1: 자동 스크립트 사용
```bash
cd "/Users/yangdeokkwan/Documents/Overleaf_Projects/학위논문_DK"
./setup_github.sh https://github.com/USERNAME/thesis.git
```

### 방법 2: 수동 설정
```bash
cd "/Users/yangdeokkwan/Documents/Overleaf_Projects/학위논문_DK"
git init
git add .
git commit -m "Initial commit: 학위논문 초기 버전"
git remote add origin https://github.com/USERNAME/thesis.git
git branch -M main
git push -u origin main
```

---

## 📝 일상 작업 명령어

### 기본 작업 흐름
```bash
# 1. 현재 상태 확인
git status

# 2. 변경된 파일 추가
git add main.tex                    # 특정 파일
git add .                           # 모든 변경사항

# 3. 커밋
git commit -m "3장 내용 추가"

# 4. GitHub에 푸시
git push

# 5. GitHub에서 가져오기 (다른 곳에서 작업했을 때)
git pull
```

### 자주 사용하는 커밋 메시지
```bash
git commit -m "초록 작성"
git commit -m "참고문헌 추가"
git commit -m "그림 3.1 수정"
git commit -m "오타 수정"
git commit -m "지도교수님 피드백 반영"
```

---

## 🔄 Overleaf 동기화

### Premium (자동 동기화)
1. Overleaf에서 작업
2. 저장 (Ctrl+S / Cmd+S)
3. ✅ 자동으로 GitHub 동기화
4. 로컬에서 `git pull` (필요시)

### Free (수동 동기화)

**Overleaf → GitHub**
```bash
# Overleaf에서 "Download Source" (ZIP)
# 압축 해제 후:
git add .
git commit -m "Overleaf 변경사항 반영"
git push
```

**GitHub → Overleaf**
```bash
# 로컬 작업 후:
git push
# Overleaf에서 "Upload" → GitHub ZIP 다운로드 후 업로드
```

**Overleaf Git 직접 사용** (고급)
```bash
# Overleaf Git URL 추가 (한 번만)
git remote add overleaf https://git.overleaf.com/YOUR_PROJECT_ID

# Overleaf로 푸시
git push overleaf main:master

# Overleaf에서 가져오기
git pull overleaf master
```

---

## 🆘 문제 해결

### 충돌 해결
```bash
# 로컬 변경사항 임시 저장
git stash

# GitHub에서 최신 버전 가져오기
git pull

# 저장한 변경사항 복원
git stash pop

# 충돌 파일 수동 편집 후
git add .
git commit -m "충돌 해결"
git push
```

### 실수한 커밋 되돌리기
```bash
# 마지막 커밋 취소 (파일은 유지)
git reset --soft HEAD~1

# 마지막 커밋 완전 취소 (파일도 되돌림)
git reset --hard HEAD~1
```

### 파일 복구
```bash
# 특정 파일을 마지막 커밋 상태로
git checkout -- main.tex

# 전체 되돌리기
git reset --hard HEAD
```

### 빌드 파일 제거
```bash
git rm --cached *.aux *.log *.fls *.fdb_latexmk *.synctex.gz
git commit -m "빌드 파일 제거"
git push
```

---

## 🏷️ 버전 관리 (태그)

### 중요 버전 표시
```bash
# 태그 생성
git tag -a v0.1 -m "초고"
git tag -a v0.5 -m "중간 제출본"
git tag -a v1.0 -m "최종 제출본"

# GitHub에 태그 푸시
git push origin --tags

# 태그 목록 보기
git tag -l

# 특정 태그로 돌아가기
git checkout v0.5
```

---

## 📊 유용한 조회 명령어

```bash
# 커밋 히스토리
git log

# 간단한 히스토리
git log --oneline

# 변경사항 보기
git diff

# 특정 파일 변경사항
git diff main.tex

# 누가 언제 수정했는지
git blame main.tex
```

---

## 🌿 브랜치 사용 (선택사항)

```bash
# 새 브랜치 만들기
git checkout -b draft-chapter4

# 브랜치 목록
git branch

# 브랜치 전환
git checkout main

# 병합
git merge draft-chapter4

# 브랜치 삭제
git branch -d draft-chapter4
```

---

## ⚙️ 설정

### Git 사용자 정보
```bash
git config --global user.name "Yang Deokkwan"
git config --global user.email "your.email@example.com"
```

### 한글 파일명 문제 해결
```bash
git config --global core.quotepath false
```

### 기본 브랜치 이름
```bash
git config --global init.defaultBranch main
```

---

## 📦 프로젝트 구조

```
학위논문_DK/
├── .git/                    # Git 저장소 (자동 생성)
├── .gitignore              # 제외할 파일 목록 ✅
├── README.md               # 프로젝트 설명 ✅
├── GITHUB_OVERLEAF_GUIDE.md # 상세 가이드 ✅
├── QUICK_REFERENCE.md      # 이 파일 ✅
├── setup_github.sh         # 자동 설정 스크립트 ✅
├── main.tex                # 메인 논문 파일
├── Ref.bib                 # 참고문헌
├── list_of_figures.tex     # 그림 목록
├── list_of_tables.tex      # 표 목록
└── figures/                # 이미지 디렉토리
    ├── *.png
    └── ...
```

---

## 🔗 체크리스트

### 초기 설정
- [ ] GitHub 저장소 생성
- [ ] Git 초기화 (`git init`)
- [ ] 첫 커밋 및 푸시
- [ ] `.gitignore` 확인
- [ ] Overleaf 연동 (선택)

### 매일 작업
- [ ] 작업 시작 전 `git pull`
- [ ] 작업 중 주기적으로 저장
- [ ] 중요한 변경 후 `git commit`
- [ ] 하루 마지막에 `git push`

### 중요 시점
- [ ] 중간 제출 전 태그 생성
- [ ] 최종 제출 전 태그 생성
- [ ] 백업 확인 (GitHub)
- [ ] PDF 다운로드 보관

---

## 📞 도움말

- **전체 가이드**: `GITHUB_OVERLEAF_GUIDE.md`
- **Git 도움말**: `git help` 또는 `git help <command>`
- **KTUG 포럼**: http://www.ktug.org/
- **GitHub 문서**: https://docs.github.com/

---

**팁**: 이 파일을 즐겨찾기에 추가하세요!
