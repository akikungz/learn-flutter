import { doublePrecision, integer, pgTable, text, varchar } from "drizzle-orm/pg-core";

export const emp = pgTable("emp", {
    id: integer().primaryKey().generatedByDefaultAsIdentity(),
    name: varchar().notNull(),
    age: integer().notNull(),
    email: varchar().notNull(),
    phone: varchar({ length: 16 }).notNull(),
    address: text().notNull(),
    weight: doublePrecision().notNull(),
    height: doublePrecision().notNull(),
});