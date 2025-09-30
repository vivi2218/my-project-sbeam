<template>
    <div class="community">
        <h1 class="page-title">社区游戏查询</h1>

        <div class="tabs">
            <div class="tab" :class="{ 'active': activeTab === 'game-search' }" @click="activeTab = 'game-search'">
                根据游戏查询</div>
            <div class="tab" :class="{ 'active': activeTab === 'genre-search' }" @click="activeTab = 'genre-search'">
                根据游戏类型查询</div>
        </div>

        <!-- 游戏查询 -->
        <div v-if="activeTab === 'game-search'">
            <div class="search-container">
                <h2 class="search-title">搜索游戏</h2>
                <form class="search-form">
                    <input type="text" class="search-input" v-model="gameSearchQuery" placeholder="输入游戏名称...">
                    <button type="button" class="search-btn" @click="searchGames">搜索</button>
                </form>
            </div>

            <div class="game-grid">
                <div class="game-card" v-for="game in filteredGames" :key="game.id">
                    <div class="game-img">游戏封面</div>
                    <div class="game-info">
                        <div class="game-title">{{ game.title }}</div>
                        <div class="game-genre">{{ game.genres.join(', ') }}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 游戏类型查询 -->
        <div v-if="activeTab === 'genre-search'">
            <div class="search-container">
                <h2 class="search-title">按类型筛选游戏</h2>
                <form class="search-form">
                    <select class="search-input" v-model="selectedGenre" @change="filterByGenre">
                        <option value="">选择游戏类型...</option>
                        <option v-for="genre in allGenres" :value="genre">{{ genre }}</option>
                    </select>
                    <button type="button" class="search-btn" @click="filterByGenre">筛选</button>
                </form>
            </div>

            <div class="game-grid">
                <div class="game-card" v-for="game in gamesByGenre" :key="game.id">
                    <div class="game-img">游戏封面</div>
                    <div class="game-info">
                        <div class="game-title">{{ game.title }}</div>
                        <div class="game-genre">{{ game.genres.join(', ') }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            activeTab: 'game-search',
            gameSearchQuery: '',
            selectedGenre: '',
            games: [
                { id: 1, title: '赛博朋克 2077', genres: ['角色扮演', '开放世界'] },
                { id: 2, title: '反恐精英：全球攻势', genres: ['射击', '多人'] },
                { id: 3, title: 'DOTA 2', genres: ['MOBA', '策略'] },
                { id: 4, title: '巫师 3：狂猎', genres: ['角色扮演', '开放世界'] },
                { id: 5, title: '只狼：影逝二度', genres: ['动作', '冒险'] },
                { id: 6, title: '黑暗之魂 3', genres: ['动作', '角色扮演'] },
                { id: 7, title: '血源诅咒', genres: ['动作', '角色扮演'] },
                { id: 8, title: '仁王 2', genres: ['动作', '角色扮演'] }
            ]
        }
    },
    computed: {
        filteredGames() {
            if (!this.gameSearchQuery) return this.games;
            const query = this.gameSearchQuery.toLowerCase();
            return this.games.filter(game =>
                game.title.toLowerCase().includes(query)
            );
        },
        allGenres() {
            const genres = new Set();
            this.games.forEach(game => {
                game.genres.forEach(genre => genres.add(genre));
            });
            return Array.from(genres);
        },
        gamesByGenre() {
            if (!this.selectedGenre) return this.games;
            return this.games.filter(game =>
                game.genres.includes(this.selectedGenre)
            );
        }
    },
    methods: {
        searchGames() {
            console.log('搜索游戏:', this.gameSearchQuery);
        },
        filterByGenre() {
            console.log('筛选类型:', this.selectedGenre);
        }
    }
}
</script>
