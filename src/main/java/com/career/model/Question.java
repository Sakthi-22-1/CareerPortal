package com.career.model;

/**
 * Question - Model class representing a quiz question.
 * 
 * Maps to the 'questions' table in the career_portal database.
 * Each question belongs to a category and has a topic tag
 * used for weak-area analysis.
 */
public class Question {

    // ---- Fields matching the 'questions' table columns ----
    private int id;
    private String category;
    private String questionText;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String correctOption;
    private String topic;

    // ---- Constructors ----

    /** Default no-argument constructor */
    public Question() {
    }

    /** Constructor with all fields (useful when reading from DB) */
    public Question(int id, String category, String questionText,
                    String optionA, String optionB, String optionC, String optionD,
                    String correctOption, String topic) {
        this.id = id;
        this.category = category;
        this.questionText = questionText;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correctOption = correctOption;
        this.topic = topic;
    }

    /** Constructor without id (useful for inserting new questions) */
    public Question(String category, String questionText,
                    String optionA, String optionB, String optionC, String optionD,
                    String correctOption, String topic) {
        this.category = category;
        this.questionText = questionText;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correctOption = correctOption;
        this.topic = topic;
    }

    // ---- Getters and Setters ----

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getCorrectOption() {
        return correctOption;
    }

    public void setCorrectOption(String correctOption) {
        this.correctOption = correctOption;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    @Override
    public String toString() {
        return "Question [id=" + id + ", category=" + category + ", topic=" + topic + "]";
    }
}
